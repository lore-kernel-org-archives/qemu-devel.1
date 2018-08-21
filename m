Received: from eggs.gnu.org ([2001:4830:134:3::10]:40298)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fs1Mj-0002v8-42
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 03:46:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fs1Mf-0003QR-S0
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 03:46:13 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:56526 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1fs1Mf-0003Px-NU
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 03:46:09 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 1C26D804BCF4
	for <qemu-devel@nongnu.org>; Tue, 21 Aug 2018 07:46:09 +0000 (UTC)
Date: Tue, 21 Aug 2018 09:46:05 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20180821074605.xr2ntzapr3vs4htf@sirius.home.kraxel.org>
References: <20180808104930.23133-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20180808104930.23133-1-berrange@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 0/3] ui: remove deprecated UI frontends
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, libvir-list@redhat.com

On Wed, Aug 08, 2018 at 11:49:27AM +0100, Daniel P. Berrang=E9 wrote:
> We deprecated GTK2 and SDL1.2 in the 2.12.0 release, so they are able t=
o
> be removed entirely in the 3.1.0 release. The min GTK3 version can also
> be bumped up based the distros we aim to support.

Doesn't apply any more.
Can you rebase and resend?

thanks,
  Gerd
