Received: from eggs.gnu.org ([2001:4830:134:3::10]:53802)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ebischoff@suse.com>) id 1cig4p-0002z2-RL
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 06:36:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ebischoff@suse.com>) id 1cig4m-0004R7-KV
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 06:36:19 -0500
Received: from charybdis-ext.suse.de ([195.135.221.2]:40700 helo=tegan.suse.de)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ebischoff@suse.com>) id 1cig4m-0004Qr-EY
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 06:36:16 -0500
From: Eric Bischoff <ebischoff@suse.com>
Date: Tue, 28 Feb 2017 12:35:34 +0100
Message-Id: <20170228113535.7099-1-ebischoff@suse.com>
Subject: [Qemu-devel] [PATCHv3] Adding support for LPD and LPDG instructions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <rth@twiddle.net>, Alexander Graf <agraf@suse.de>
Cc: Michal Marek <mmarek@suse.cz>, Miroslav Benes <mbenes@suse.cz>, QEmu developers <qemu-devel@nongnu.org>

Third patch, trying to do real interlocking
