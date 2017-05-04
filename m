Received: from eggs.gnu.org ([2001:4830:134:3::10]:36791)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1d6MbK-0005MK-O7
	for qemu-devel@nongnu.org; Thu, 04 May 2017 15:39:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1d6MbH-0005yh-ME
	for qemu-devel@nongnu.org; Thu, 04 May 2017 15:39:46 -0400
Received: from mail-io0-x22a.google.com ([2607:f8b0:4001:c06::22a]:33276)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <programmingkidx@gmail.com>)
	id 1d6MbH-0005yN-GM
	for qemu-devel@nongnu.org; Thu, 04 May 2017 15:39:43 -0400
Received: by mail-io0-x22a.google.com with SMTP id p24so35537107ioi.0
	for <qemu-devel@nongnu.org>; Thu, 04 May 2017 12:39:43 -0700 (PDT)
Mime-Version: 1.0 (Apple Message framework v753.1)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <4E2A0E2A-7A9D-4340-8FC8-A2B0C9DB8271@gmail.com>
Content-Transfer-Encoding: 7bit
From: G 3 <programmingkidx@gmail.com>
Date: Thu, 4 May 2017 15:39:38 -0400
Subject: [Qemu-devel] risugen: test only instructions that begin with the
 letter F
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

I'm trying to test all the floating point instructions only. They  
tend to begin with the letter f. Is there a way to have risugen only  
use instructions that begin with the letter F?
