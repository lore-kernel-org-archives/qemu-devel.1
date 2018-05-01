Received: from eggs.gnu.org ([2001:4830:134:3::10]:41201)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mathew1800@gmail.com>) id 1fDaLb-0003xa-8q
	for qemu-devel@nongnu.org; Tue, 01 May 2018 14:49:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mathew1800@gmail.com>) id 1fDaLY-0006zR-5M
	for qemu-devel@nongnu.org; Tue, 01 May 2018 14:49:55 -0400
Received: from mail-it0-x22a.google.com ([2607:f8b0:4001:c0b::22a]:35283)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mathew1800@gmail.com>)
	id 1fDaLX-0006zB-Tg
	for qemu-devel@nongnu.org; Tue, 01 May 2018 14:49:52 -0400
Received: by mail-it0-x22a.google.com with SMTP id 186-v6so14152671itu.0
	for <qemu-devel@nongnu.org>; Tue, 01 May 2018 11:49:51 -0700 (PDT)
From: Mathew Maidment <mathew1800@gmail.com>
Date: Tue,  1 May 2018 14:49:32 -0400
Message-Id: <20180501184933.37609-1-mathew1800@gmail.com>
Subject: [Qemu-devel] [PATCH 0/1] target/arm: Correct MPUIR PL setting in
 register_cp_regs_for_features()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org

Hey there! This is my first time sending a patch via a mailing list so
hopefully I didn't bungle this up *too* badly.

Mat

Mathew Maidment (1):
  target/arm: Correct MPUIR privilege level in
    register_cp_regs_for_features()

 target/arm/helper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

-- 
2.15.1
