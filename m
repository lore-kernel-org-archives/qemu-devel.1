Received: from eggs.gnu.org ([2001:4830:134:3::10]:60790)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1etNoy-0006dW-RP
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 20:24:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1etNov-0004F3-Nx
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 20:24:44 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:57746 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1etNov-0004Ef-Jn
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 20:24:41 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id D0432402315A
	for <qemu-devel@nongnu.org>; Wed,  7 Mar 2018 01:24:37 +0000 (UTC)
Date: Wed, 7 Mar 2018 09:24:30 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20180307012430.GC13844@lemon.usersys.redhat.com>
References: <20180306154625.23910-1-berrange@redhat.com>
	<152035274652.1398.7213039081791775077@bdbb90650ae5>
	<20180306162247.GR6163@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20180306162247.GR6163@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] trace: only permit standard C types and
 fixed size integer types
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, stefanha@redhat.com

On Tue, 03/06 16:22, Daniel P. Berrang=E9 wrote:
> RFE for patchew...
>=20
> Now we're sending separate email alerts for each build job, can we
> make patchew include the job name in the subject line, so it is
> immediately obvious which job failed without needing to read the
> body.

Yes, doable. Do we still want the original subject (The "Re: ..." part)? =
If so,
any idea what is a good format for the full subject line?

Fam
