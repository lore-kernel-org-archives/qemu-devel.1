Received: from eggs.gnu.org ([2001:4830:134:3::10]:57972)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1dW260-0008Gr-M7
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 11:01:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1dW25w-00053t-T4
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 11:01:32 -0400
Received: from mail-it0-x22d.google.com ([2607:f8b0:4001:c0b::22d]:35528)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <programmingkidx@gmail.com>)
	id 1dW25w-00053G-Od
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 11:01:28 -0400
Received: by mail-it0-x22d.google.com with SMTP id v202so23071425itb.0
	for <qemu-devel@nongnu.org>; Fri, 14 Jul 2017 08:01:26 -0700 (PDT)
From: Programmingkid <programmingkidx@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Date: Fri, 14 Jul 2017 11:01:24 -0400
Message-Id: <E069C2FF-508A-4F1B-8821-BAE8451D06F6@gmail.com>
Mime-Version: 1.0 (Apple Message framework v1084)
Subject: [Qemu-devel] help with tilegx
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: xili_gchen_5257@hotmail.com
Cc: "qemu-devel@nongnu.org qemu-devel" <qemu-devel@nongnu.org>

How do I build the tilegx target? I have tried "./configure =
--target-list=3Dtilegx" and "./configure --target-list=3Dtilegx-softmmu". =
They both fail with this message: "ERROR: Unknown target name".=
