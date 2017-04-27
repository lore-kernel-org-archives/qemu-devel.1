Received: from eggs.gnu.org ([2001:4830:134:3::10]:41495)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ali.saeedi56@gmail.com>) id 1d3fPW-0002bl-5g
	for qemu-devel@nongnu.org; Thu, 27 Apr 2017 05:08:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ali.saeedi56@gmail.com>) id 1d3fPV-0002Sy-Dg
	for qemu-devel@nongnu.org; Thu, 27 Apr 2017 05:08:26 -0400
Received: from mail-qk0-x231.google.com ([2607:f8b0:400d:c09::231]:34177)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <ali.saeedi56@gmail.com>)
	id 1d3fPV-0002SQ-90
	for qemu-devel@nongnu.org; Thu, 27 Apr 2017 05:08:25 -0400
Received: by mail-qk0-x231.google.com with SMTP id y63so22076459qkd.1
	for <qemu-devel@nongnu.org>; Thu, 27 Apr 2017 02:08:25 -0700 (PDT)
MIME-Version: 1.0
From: ali saeedi <ali.saeedi56@gmail.com>
Date: Thu, 27 Apr 2017 13:38:24 +0430
Message-ID: <CAGKXQyehD4w9o+nLWme85HEovR+=q=mRhm9CTp=f_5ZO4mLPVw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: [Qemu-devel] qemu_savevm_state_header(s->to_dst_file)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Hi
does 'qemu_savevm_state_header(s->to_dst_file)' function in migration.c
only stores header in qemu file and does not send it to destination? if it
sends to destination  which function does that?
thanks alot
