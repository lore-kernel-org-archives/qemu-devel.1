Received: from eggs.gnu.org ([2001:4830:134:3::10]:47947)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1eZxpZ-0006Iq-KU
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 06:49:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1eZxpV-0002T7-Lr
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 06:49:05 -0500
Received: from mx1.redhat.com ([209.132.183.28]:39228)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1eZxpV-0002Ho-Fm
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 06:49:01 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 7AE9681DF3
	for <qemu-devel@nongnu.org>; Fri, 12 Jan 2018 11:48:49 +0000 (UTC)
Date: Fri, 12 Jan 2018 12:48:44 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20180112114844.zjlwxqxrzvrjotrd@sirius.home.kraxel.org>
References: <20171218191228.31018-1-berrange@redhat.com>
	<20171218191228.31018-2-berrange@redhat.com>
	<20180108110849.325psbrk6g7bstsc@sirius.home.kraxel.org>
	<20180110135513.GV3205@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20180110135513.GV3205@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v1 01/13] ui: remove 'sync' parametr from
 vnc_update_client
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>, P J P <ppandit@redhat.com>

> > What is the state of this series btw (/me busy wading through my
> > email backlog ...) ?
>=20
> Marc-Andr=E9 reviewed it, but I was assuming you would want to review a=
nd
> (if acceptable) queue it, since you're the designated VNC maintainer.
> There's just one nit-pick in the Subject of this mail so far.

Ok, queued, fixed $subject tyops, test builds running ...

thanks,
  Gerd
