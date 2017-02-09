Received: from eggs.gnu.org ([2001:4830:134:3::10]:60973)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <abologna@redhat.com>) id 1cbmLI-0005cW-7K
	for qemu-devel@nongnu.org; Thu, 09 Feb 2017 05:52:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <abologna@redhat.com>) id 1cbmLF-0007W9-4e
	for qemu-devel@nongnu.org; Thu, 09 Feb 2017 05:52:48 -0500
Received: from mx1.redhat.com ([209.132.183.28]:47886)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <abologna@redhat.com>) id 1cbmLE-0007VE-Uq
	for qemu-devel@nongnu.org; Thu, 09 Feb 2017 05:52:45 -0500
Received: from int-mx11.intmail.prod.int.phx2.redhat.com
	(int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 010AA3DBD7
	for <qemu-devel@nongnu.org>; Thu,  9 Feb 2017 10:52:45 +0000 (UTC)
Message-ID: <1486637562.3641.38.camel@redhat.com>
From: Andrea Bolognani <abologna@redhat.com>
Date: Thu, 09 Feb 2017 11:52:42 +0100
In-Reply-To: <20170209094910.mrfhyjixmwr5kofb@kamzik.brq.redhat.com>
References: <1486575331-14455-1-git-send-email-abologna@redhat.com>
	<1486575331-14455-3-git-send-email-abologna@redhat.com>
	<3fa3d4b8-3e3a-d6c4-a2c1-affef7361576@redhat.com>
	<20170209094910.mrfhyjixmwr5kofb@kamzik.brq.redhat.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v5 2/2] mach-virt: Provide sample
 configuration files
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Andrew Jones <drjones@redhat.com>, Laszlo Ersek <lersek@redhat.com>
Cc: qemu-devel@nongnu.org, marcel@redhat.com, kraxel@redhat.com

On Thu, 2017-02-09 at 10:49 +0100, Andrew Jones wrote:
> > > +# RHEL:
> > > +#=C2=A0=C2=A0=C2=A0/usr/share/AAVMF/AAVMF_CODE.fd
> > > +#=C2=A0=C2=A0=C2=A0/usr/share/AAVMF/AAVMF_VARS.fd
> >=C2=A0
> > Looks legit. (Might want to call "RHEL" "RHELSA" though, in this cont=
ext
> > -- no clue. Ask Drew :))
>=C2=A0
> The first choice "RHEL" is correct. "RHELSA" still exists today,
> but eventually that name should be phased out (IIUC), as AArch64
> will be "just another RHEL arch", requiring no special name.

Can't wait for that day! I'll leave it unchanged then :)

--=C2=A0
Andrea Bolognani / Red Hat / Virtualization
