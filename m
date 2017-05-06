Received: from eggs.gnu.org ([2001:4830:134:3::10]:54056)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ali.saeedi56@gmail.com>) id 1d6xxx-0005Bc-Gg
	for qemu-devel@nongnu.org; Sat, 06 May 2017 07:33:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ali.saeedi56@gmail.com>) id 1d6xxw-0002CA-N7
	for qemu-devel@nongnu.org; Sat, 06 May 2017 07:33:37 -0400
Received: from mail-qt0-x232.google.com ([2607:f8b0:400d:c0d::232]:33316)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <ali.saeedi56@gmail.com>)
	id 1d6xxw-0002Bs-HA
	for qemu-devel@nongnu.org; Sat, 06 May 2017 07:33:36 -0400
Received: by mail-qt0-x232.google.com with SMTP id t26so6742482qtg.0
	for <qemu-devel@nongnu.org>; Sat, 06 May 2017 04:33:36 -0700 (PDT)
MIME-Version: 1.0
From: ali saeedi <ali.saeedi56@gmail.com>
Date: Sat, 6 May 2017 16:03:35 +0430
Message-ID: <CAGKXQyfu6_wHmXiJZ2_19BpCkGJ60twdHQ74MV9=up7v-co1Jg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: [Qemu-devel] vmstate_save_state
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

what does "vmstate_save_state(f, &vmstate_configuration, &savevm_state, 0)"
function call do in "qemu_savevm_state_header" function in savevm.c at line
968 ?
why has "savevm_state" been passed to this function?
thanks a lot
