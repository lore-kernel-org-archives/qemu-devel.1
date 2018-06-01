Received: from eggs.gnu.org ([2001:4830:134:3::10]:50087)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <randrianasulu@gmail.com>) id 1fOndj-0005kM-BF
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 13:15:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <randrianasulu@gmail.com>) id 1fOndg-0001gV-0Q
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 13:14:59 -0400
Received: from mail-lf0-x235.google.com ([2a00:1450:4010:c07::235]:38208)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <randrianasulu@gmail.com>)
	id 1fOndf-0001df-PF
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 13:14:55 -0400
Received: by mail-lf0-x235.google.com with SMTP id i83-v6so3693297lfh.5
	for <qemu-devel@nongnu.org>; Fri, 01 Jun 2018 10:14:55 -0700 (PDT)
Received: from [192.168.1.101] ([176.116.252.109])
	by smtp.gmail.com with ESMTPSA id
	q25-v6sm8173772ljj.68.2018.06.01.10.14.52 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 01 Jun 2018 10:14:52 -0700 (PDT)
From: Andrew Randrianasulu <randrianasulu@gmail.com>
Date: Fri, 1 Jun 2018 19:58:32 +0300
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Message-Id: <201806011958.32433.randrianasulu@gmail.com>
Subject: Re: [Qemu-devel] [Bug 1769189] Re: Issue with qemu 2.12.0 + SATA
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

=46or me issue was fixed with =AB[PATCH 2/3] ahci: fix PxCI register race=BB

I additionally patched my qemu build with "[PATCH] e1000e: Do not auto-clea=
r ICR=20
bits which aren't set in EIAC" - so new network adapter for q35 machine wor=
ks=20
with KDE Neon liveDVD for example ....
