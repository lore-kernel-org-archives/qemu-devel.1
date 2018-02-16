Received: from eggs.gnu.org ([2001:4830:134:3::10]:60084)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1empcf-0005E3-N1
	for qemu-devel@nongnu.org; Fri, 16 Feb 2018 18:40:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1empcd-0000Tl-4Y
	for qemu-devel@nongnu.org; Fri, 16 Feb 2018 18:40:57 -0500
From: "Emilio G. Cota" <cota@braap.org>
Date: Fri, 16 Feb 2018 18:40:43 -0500
Message-Id: <1518824446-20235-1-git-send-email-cota@braap.org>
Subject: [Qemu-devel] [PATCH 0/3] target/s390x: translation loop conversion
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <rth@twiddle.net>, Alexander Graf <agraf@suse.de>, David Hildenbrand <david@redhat.com>, Cornelia Huck <cohuck@redhat.com>, qemu-s390x@nongnu.org

Tested with the "Moon Buggy" image:
  http://www.qemu-advent-calendar.org/2014/#day-22

Thanks,

		Emilio
