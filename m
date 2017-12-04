Received: from eggs.gnu.org ([2001:4830:134:3::10]:57966)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <iank@fsf.org>) id 1eLwwe-0006eu-Qx
	for qemu-devel@nongnu.org; Mon, 04 Dec 2017 15:02:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <iank@fsf.org>) id 1eLwwb-0000Ll-PC
	for qemu-devel@nongnu.org; Mon, 04 Dec 2017 15:02:28 -0500
Received: from li.iankelling.org ([72.14.176.105]:57874
	helo=mail.iankelling.org)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <iank@fsf.org>) id 1eLwwb-0000Kj-In
	for qemu-devel@nongnu.org; Mon, 04 Dec 2017 15:02:25 -0500
Received: from iank by mail.iankelling.org with local (Exim 4.86_2)
	(envelope-from <iank@fsf.org>) id 1eLwwZ-0002oG-Nn
	for qemu-devel@nongnu.org; Mon, 04 Dec 2017 15:02:23 -0500
From: Ian Kelling <iank@fsf.org>
Date: Mon, 04 Dec 2017 15:02:23 -0500
Message-ID: <87bmjeqn1s.fsf@fsf.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] qemu-devel archive search was missing some messages
 but it's fixed now
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Hi. I work at FSF and help maintain the mailing lists software.

I don't know exactly how many were missing because there was an error we
were ignoring. At least some from November. I fixed it by reindexing
from scratch. I didn't figure out the the root cause, likely something
to do with incremental indexing. But we are no longer ignoring errors,
so we will fix issues if they occur again.

General thoughts about the archive: I'm looking forward to us upgrading
to mailman 3 at some point which will bring an improved archive
interface. Of course, you can always download the archive and search it
on your local computer.

-- 
Ian Kelling | Senior Systems Administrator, Free Software Foundation
GPG Key: B125 F60B 7B28 7FF6 A2B7  DF8F 170A F0E2 9542 95DF
https://fsf.org | https://gnu.org
