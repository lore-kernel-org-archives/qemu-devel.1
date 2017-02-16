Received: from eggs.gnu.org ([2001:4830:134:3::10]:44521)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <a175818323@gmail.com>) id 1ceJGM-0004nr-Eb
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 05:26:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <a175818323@gmail.com>) id 1ceJGL-0008LH-Ik
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 05:26:10 -0500
Received: from mail-ot0-x22b.google.com ([2607:f8b0:4003:c0f::22b]:34007)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <a175818323@gmail.com>)
	id 1ceJGL-0008K5-Dw
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 05:26:09 -0500
Received: by mail-ot0-x22b.google.com with SMTP id t47so8263473ota.1
	for <qemu-devel@nongnu.org>; Thu, 16 Feb 2017 02:26:06 -0800 (PST)
MIME-Version: 1.0
From: Bob Chen <a175818323@gmail.com>
Date: Thu, 16 Feb 2017 18:26:05 +0800
Message-ID: <CAMxP3BT90xgAGFhhMxaSz=3GA3Kd-6oiKNDc0C1bs8Msbnfb9w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: [Qemu-devel] Is it safe to replace files under /user/local/share
 in-flight?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Hi,

I want to upgrade my qemu, is it safe to replace these ROM and keymap files
in-flight while qemu processes are still running?
