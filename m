Received: from eggs.gnu.org ([2001:4830:134:3::10]:41959)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <msuchanek@suse.de>) id 1gOkKs-0001nk-Km
	for qemu-devel@nongnu.org; Mon, 19 Nov 2018 09:15:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <msuchanek@suse.de>) id 1gOkKp-00059q-VW
	for qemu-devel@nongnu.org; Mon, 19 Nov 2018 09:15:34 -0500
Received: from mx2.suse.de ([195.135.220.15]:38210 helo=mx1.suse.de)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <msuchanek@suse.de>) id 1gOkKp-00052O-P4
	for qemu-devel@nongnu.org; Mon, 19 Nov 2018 09:15:31 -0500
Received: from relay2.suse.de (unknown [195.135.220.254])
	by mx1.suse.de (Postfix) with ESMTP id EA101AF03
	for <qemu-devel@nongnu.org>; Mon, 19 Nov 2018 14:15:29 +0000 (UTC)
Date: Mon, 19 Nov 2018 15:15:27 +0100
From: Michal =?UTF-8?B?U3VjaMOhbmVr?= <msuchanek@suse.de>
Message-ID: <20181119151527.4a925a75@naga>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] Block format 'raw' does not support the option 'serial'
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Hello,

I tried to run my VM with qemu git and I am greeted with:

Block format 'raw' does not support the option 'serial'

Is there any sensible reason to *not^ support disk serial number?

Thanks

Michal
