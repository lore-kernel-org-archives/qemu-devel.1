Received: from eggs.gnu.org ([2001:4830:134:3::10]:58130)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <atar4qemu@gmail.com>) id 1cW7Cl-0006ev-Ts
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 14:56:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <atar4qemu@gmail.com>) id 1cW7Cg-0000kx-1a
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 14:56:34 -0500
Received: from mail-wj0-x243.google.com ([2a00:1450:400c:c01::243]:34556)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <atar4qemu@gmail.com>) id 1cW7Cf-0000jm-SG
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 14:56:29 -0500
Received: by mail-wj0-x243.google.com with SMTP id ip10so3199174wjb.1
	for <qemu-devel@nongnu.org>; Tue, 24 Jan 2017 11:56:27 -0800 (PST)
From: Artyom Tarasenko <atar4qemu@gmail.com>
Date: Tue, 24 Jan 2017 20:55:40 +0100
Message-Id: <1485287742-31374-1-git-send-email-atar4qemu@gmail.com>
Subject: [Qemu-devel] [PATCH v2 0/2] niagara fixes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk, armbru@redhat.com, peter.maydell@linaro.org, Artyom Tarasenko <atar4qemu@gmail.com>

niagara fixes

Artyom Tarasenko (2):
  niagara: fail if a firmware file is missing
  niagara: check if a serial port is available

 hw/sparc64/niagara.c | 33 +++++++++++++++++++++++----------
 1 file changed, 23 insertions(+), 10 deletions(-)

-- 
2.7.2
