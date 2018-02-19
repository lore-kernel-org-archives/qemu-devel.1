Received: from eggs.gnu.org ([2001:4830:134:3::10]:53576)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <xucaen@gmail.com>) id 1ennIu-0005zI-Tj
	for qemu-devel@nongnu.org; Mon, 19 Feb 2018 10:24:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <xucaen@gmail.com>) id 1ennIt-0002IM-Ph
	for qemu-devel@nongnu.org; Mon, 19 Feb 2018 10:24:32 -0500
Received: from mail-lf0-x22e.google.com ([2a00:1450:4010:c07::22e]:34255)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <xucaen@gmail.com>) id 1ennIt-0002Fo-HB
	for qemu-devel@nongnu.org; Mon, 19 Feb 2018 10:24:31 -0500
Received: by mail-lf0-x22e.google.com with SMTP id l191so4072lfe.1
	for <qemu-devel@nongnu.org>; Mon, 19 Feb 2018 07:24:31 -0800 (PST)
MIME-Version: 1.0
From: James Barrett <xucaen@gmail.com>
Date: Mon, 19 Feb 2018 10:24:28 -0500
Message-ID: <CAG9FBFpFBrUrG0bRwjAo6xHYG4rnc0BT_ufLSa-HsO2WWgvKJw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: [Qemu-devel] qemu warnings and errors
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

I keep getting these warnings with a message to send email to
qemu-devel@nongnu.org

here is the command I am using:

qemu-system-i386 -hda bbs.hd -fda bbs.fd -hdb fat:rw:dist


Host OS is Ubunti 17.10, guest OS is MS-DOS 6.22



WARNING: Image format was not specified for 'bbs.hd' and probing guessed
raw.
         Automatically detecting the format is dangerous for raw images,
write operations on block 0 will be restricted.
         Specify the 'raw' format explicitly to remove the restrictions.
WARNING: Image format was not specified for 'bbs.fd' and probing guessed
raw.
         Automatically detecting the format is dangerous for raw images,
write operations on block 0 will be restricted.
         Specify the 'raw' format explicitly to remove the restrictions.
vvfat dist chs 1024,16,63
WARNING: Image format was not specified for 'json:{"fat-type": 0, "dir":
"dist", "driver": "vvfat", "floppy": false, "rw": true}' and probing
guessed raw.
         Automatically detecting the format is dangerous for raw images,
write operations on block 0 will be restricted.
         Specify the 'raw' format explicitly to remove the restrictions.
unknown keycodes `(unnamed)', please report to qemu-devel@nongnu.org
