Received: from eggs.gnu.org ([2001:4830:134:3::10]:43495)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <hejianet@gmail.com>) id 1fWB81-0004wZ-6B
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 21:44:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <hejianet@gmail.com>) id 1fWB80-0002i1-Ge
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 21:44:45 -0400
From: Jia He <hejianet@gmail.com>
Message-ID: <d5f8be99-9602-a628-bc43-486e7befc4dc@gmail.com>
Date: Fri, 22 Jun 2018 09:44:33 +0800
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [Questio] What the proper vfio NIC for emulation smmu?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Auger <eric.auger@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org

Hi Eric
I want to test your smmu emulation patchset with vfio-pci ethernet device.
Could you kindly give me the NIC type information.
In my test, there is vf probe error for menallox connect 4 NIC and TX Unit
hang error for Intel X540 NIC. That's the reason why I ask this question.

-- 
Cheers,
Jia
