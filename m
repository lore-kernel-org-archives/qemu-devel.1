Received: from eggs.gnu.org ([2001:4830:134:3::10]:41954)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wlfightup@gmail.com>) id 1e1X3a-0001W3-V2
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 08:21:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wlfightup@gmail.com>) id 1e1X3a-0003kB-5N
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 08:21:14 -0400
Received: from mail-qt0-x22b.google.com ([2607:f8b0:400d:c0d::22b]:46818)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <wlfightup@gmail.com>) id 1e1X3a-0003jj-0l
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 08:21:14 -0400
Received: by mail-qt0-x22b.google.com with SMTP id 1so2462605qtn.3
	for <qemu-devel@nongnu.org>; Mon, 09 Oct 2017 05:21:13 -0700 (PDT)
MIME-Version: 1.0
From: Paul Schlacter <wlfightup@gmail.com>
Date: Mon, 9 Oct 2017 20:21:12 +0800
Message-ID: <CADak6y7ZKX5oJv+oqFG1Kz2_mVArsnM18mw3uqAd3ei-s3JYVw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: [Qemu-devel] hot plug cpu report error
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

report error:

intel_rapl: no valid rapl domains found in package 0

intel_rapl: no valid rapl domains found in package 0


and then will shutdown after in a moment of time


qemu log :

qemu: qemu_mutex_lock: Invalid argument
2017-10-09 09:27:34.781+0000: shutting down, reason=crashed


Find a solution
