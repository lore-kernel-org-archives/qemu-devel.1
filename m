Received: from eggs.gnu.org ([2001:4830:134:3::10]:35802)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <linux@roeck-us.net>) id 1fYFYk-0001J8-0W
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 14:52:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <linux@roeck-us.net>) id 1fYFYg-0001dY-SL
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 14:52:53 -0400
Received: from bh-25.webhostbox.net ([208.91.199.152]:42485)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <linux@roeck-us.net>) id 1fYFYg-0001cC-KE
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 14:52:50 -0400
Date: Wed, 27 Jun 2018 11:52:48 -0700
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <20180627185248.GA19743@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [Qemu-devel] Linux kernel configurations for various Microblaze
 systems
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michal Simek <monstr@monstr.eu>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Cc: linux-kernel@vger.kernel.org, qemu-devel@nongnu.org

Hi,

I would like to add Microblaze "petalogix-ml605" and "xlnx-zynqmp-pmu"
to my list of qemu boot tests of upstream and stable release kernels.

Unfortunately I have been unable to locate working kernel configurations
for the those systems, nor working qemu command lines. I found a few links,
but they are all dead.

I would appreciate any help to get this working. 

Thanks,
Guenter
