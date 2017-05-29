Received: from eggs.gnu.org ([2001:4830:134:3::10]:48166)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <drjones@redhat.com>) id 1dFOcE-0005Ln-NP
	for qemu-devel@nongnu.org; Mon, 29 May 2017 13:38:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <drjones@redhat.com>) id 1dFOcE-0002S5-2Q
	for qemu-devel@nongnu.org; Mon, 29 May 2017 13:38:02 -0400
From: Andrew Jones <drjones@redhat.com>
Date: Mon, 29 May 2017 19:37:49 +0200
Message-Id: <20170529173751.3443-1-drjones@redhat.com>
Subject: [Qemu-devel] [PATCH 0/2] hw/arm/virt: numa: provide distance info
 when needed
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Cc: zhaoshenglong@huawei.com, peter.maydell@linaro.org

Andrew Jones (2):
  hw/arm/virt-acpi-build: build SLIT when needed
  hw/arm/virt: fdt: generate distance-map when needed

 hw/arm/virt-acpi-build.c |  4 ++++
 hw/arm/virt.c            | 21 +++++++++++++++++++++
 2 files changed, 25 insertions(+)

-- 
2.9.4
