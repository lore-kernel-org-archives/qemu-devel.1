Received: from eggs.gnu.org ([209.51.188.92]:44269)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1hFocm-0004Dp-Sx
	for qemu-devel@nongnu.org; Sun, 14 Apr 2019 19:33:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1hFocm-0000dl-0z
	for qemu-devel@nongnu.org; Sun, 14 Apr 2019 19:33:24 -0400
Received: from mail-io1-xd33.google.com ([2607:f8b0:4864:20::d33]:41652)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <programmingkidx@gmail.com>)
	id 1hFocl-0000cu-Li
	for qemu-devel@nongnu.org; Sun, 14 Apr 2019 19:33:23 -0400
Received: by mail-io1-xd33.google.com with SMTP id v10so13098553iom.8
	for <qemu-devel@nongnu.org>; Sun, 14 Apr 2019 16:33:22 -0700 (PDT)
Received: from [192.168.0.2] (d14-69-20-184.try.wideopenwest.com.
	[69.14.184.20]) by smtp.gmail.com with ESMTPSA id
	n21sm17820147ioo.3.2019.04.14.16.33.20 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Sun, 14 Apr 2019 16:33:20 -0700 (PDT)
From: Programmingkid <programmingkidx@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Message-Id: <839EC771-5973-4B05-BC76-D6CC5EE63A43@gmail.com>
Date: Sun, 14 Apr 2019 19:33:17 -0400
Subject: [Qemu-devel] Booting from a Bootcamp partition
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: QEMU Developers <qemu-devel@nongnu.org>

Hi I was wondering if anyone has been able to boot from a bootcamp =
partition inside of QEMU. I know this partition can be used in QEMU but =
my own attempts at booting Windows 7 on my bootcamp partition did not =
work. I always see "A disk read error occurred". Has anyone else been =
successful at this?=20=
