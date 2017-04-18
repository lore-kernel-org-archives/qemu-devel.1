Received: from eggs.gnu.org ([2001:4830:134:3::10]:37364)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1d0Kcz-0000DC-69
	for qemu-devel@nongnu.org; Tue, 18 Apr 2017 00:20:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1d0Kcw-0000O9-3j
	for qemu-devel@nongnu.org; Tue, 18 Apr 2017 00:20:33 -0400
Received: from mail-io0-x22b.google.com ([2607:f8b0:4001:c06::22b]:36114)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <programmingkidx@gmail.com>)
	id 1d0Kcv-0000Nv-VV
	for qemu-devel@nongnu.org; Tue, 18 Apr 2017 00:20:30 -0400
Received: by mail-io0-x22b.google.com with SMTP id o22so55060185iod.3
	for <qemu-devel@nongnu.org>; Mon, 17 Apr 2017 21:20:29 -0700 (PDT)
Mime-Version: 1.0 (Apple Message framework v753.1)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <E8F93B5C-51EA-46F6-849E-3C0A2C2E33E1@gmail.com>
Content-Transfer-Encoding: 7bit
From: G 3 <programmingkidx@gmail.com>
Date: Tue, 18 Apr 2017 00:20:25 -0400
Subject: [Qemu-devel] define constant in .risu file
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: "qemu-devel@nongnu.org qemu-devel" <qemu-devel@nongnu.org>

Is there a way to define a constant in a .risu file? Something like  
this:

my $upper_imm_limit = 500;
