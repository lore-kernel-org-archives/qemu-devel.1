Received: from eggs.gnu.org ([209.51.188.92]:58718)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1h1t3f-0006FA-O8
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 08:27:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1h1t3f-00009Y-5c
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 08:27:35 -0500
Received: from mx1.redhat.com ([209.132.183.28]:55720)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1h1t3e-00009K-VS
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 08:27:35 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
	[10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 30276BDFA
	for <qemu-devel@nongnu.org>; Thu,  7 Mar 2019 13:27:34 +0000 (UTC)
Date: Thu, 7 Mar 2019 14:27:30 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20190307132730.trnlurxyuvptywcu@sirius.home.kraxel.org>
References: <20190227145755.26556-1-berrange@redhat.com>
	<20190307122358.GV32268@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20190307122358.GV32268@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 0/2] ui: support for authorization control
 on TLS connections
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, libvir-list@redhat.com, Markus Armbruster <armbru@redhat.com>

On Thu, Mar 07, 2019 at 12:23:58PM +0000, Daniel P. Berrang=E9 wrote:
> ping - soft freeze is less than a week away & i'd like this to get into
> a ui queue pull request in time for 4.0 if there's no review objections

I'm aware, I'm busy preparing the pre-freeze pulls.  USB is on the list
already, busy with UI right now. VGA comes next.

Series queued.

cheers,
  Gerd
