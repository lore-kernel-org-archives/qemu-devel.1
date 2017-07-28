Received: from eggs.gnu.org ([2001:4830:134:3::10]:40016)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dbF77-0001Ge-VV
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 19:56:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dbF75-00048J-DC
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 19:56:14 -0400
Received: from mail-qt0-x231.google.com ([2607:f8b0:400d:c0d::231]:35809)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dbF75-00047u-8R
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 19:56:11 -0400
Received: by mail-qt0-x231.google.com with SMTP id p3so84870747qtg.2
	for <qemu-devel@nongnu.org>; Fri, 28 Jul 2017 16:56:11 -0700 (PDT)
Received: from [192.168.1.10] ([138.117.48.223])
	by smtp.gmail.com with ESMTPSA id
	d206sm9284573qke.81.2017.07.28.16.56.08 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 28 Jul 2017 16:56:09 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <16148252-7ec9-bc6f-023f-d0c12efc2444@amsat.org>
Date: Fri, 28 Jul 2017 20:56:06 -0300
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] make check-help not working
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

I'm a bit lost with this error:

(master)$ make check-help V=1
cc -nostdlib  -o check-help.mo
cc: fatal error: no input files
compilation terminated.
rules.mak:115: recipe for target 'check-help.mo' failed
make: *** [check-help.mo] Error 1

Phil.
