Received: from eggs.gnu.org ([2001:4830:134:3::10]:33986)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <abologna@redhat.com>) id 1cZZPY-0003R4-1E
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 03:40:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <abologna@redhat.com>) id 1cZZPV-0002sp-0R
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 03:40:04 -0500
Received: from mx1.redhat.com ([209.132.183.28]:55428)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <abologna@redhat.com>) id 1cZZPU-0002sk-Qu
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 03:40:00 -0500
Received: from int-mx09.intmail.prod.int.phx2.redhat.com
	(int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id E8E08C05678D
	for <qemu-devel@nongnu.org>; Fri,  3 Feb 2017 08:40:00 +0000 (UTC)
Message-ID: <1486111198.3484.27.camel@redhat.com>
From: Andrea Bolognani <abologna@redhat.com>
Date: Fri, 03 Feb 2017 09:39:58 +0100
In-Reply-To: <1486073625.20628.57.camel@redhat.com>
References: <1485969640-8149-1-git-send-email-abologna@redhat.com>
	<25c8a78b-1d81-2a62-61ac-722d22999c41@redhat.com>
	<1486048853.3484.21.camel@redhat.com>
	<1486073625.20628.57.camel@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2] q35: Improve sample configuration files
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: Marcel Apfelbaum <marcel@redhat.com>, qemu-devel@nongnu.org, drjones@redhat.com

On Thu, 2017-02-02 at 23:13 +0100, Gerd Hoffmann wrote:
> > Not sure about this one. It doesn't show up on my laptop,
> > so it's not like every single q35-based physical machine has
> > it.
>=C2=A0
> Is your laptop really q35+ich9 or something newer?

Nope, something newer. Sorry for overlooking this.

> > I'd be okay with dropping it, but I leave the decision
> > to Gerd.
>=C2=A0
> Please leave it in for qemu-emulated.cfg, as this is supposed to serve
> as documentation how real q35 hardware looks like.
>=C2=A0
> From the virtio variants it can be dropped.

It was not there to begin with ;)

--=C2=A0
Andrea Bolognani / Red Hat / Virtualization
