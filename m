Received: from eggs.gnu.org ([2001:4830:134:3::10]:58408)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cordius.wu@huawei.com>) id 1f6puN-0004Bs-22
	for qemu-devel@nongnu.org; Fri, 13 Apr 2018 00:01:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cordius.wu@huawei.com>) id 1f6puJ-0000np-Q4
	for qemu-devel@nongnu.org; Fri, 13 Apr 2018 00:01:55 -0400
Received: from [45.249.212.255] (port=58719 helo=huawei.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cordius.wu@huawei.com>)
	id 1f6puJ-0000cE-EP
	for qemu-devel@nongnu.org; Fri, 13 Apr 2018 00:01:51 -0400
From: "Wuzongyong (Euler Dept)" <cordius.wu@huawei.com>
Date: Fri, 13 Apr 2018 03:14:44 +0000
Message-ID: <9BD73EA91F8E404F851CF3F519B14AA801719260@dggemi501-mbs.china.huawei.com>
Content-Language: zh-CN
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] Hot add vcpu not working in Windows server 2012r2
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "imammedo@redhat.com" <imammedo@redhat.com>
Cc: "Wanzongshun (Vincent)" <wanzongshun@huawei.com>, huangfeiqing <huangfeiqing@huawei.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>

Hi,

I try to hot add vcpus to a windows server 2012r2 virtual machine on RHEL 7=
.4 platform.
But Task Manager didn't show extra processors I hot added though they appea=
red in
Device Manager. Actually, I need to require reboot the vm to make processor=
s hot
Added appear in Task Manager.
Is there some problem with redhat qemu? Why the processors I hot-added didn=
't online
automatically?
I don't know if I ask the right person or in a right mail list, apologize f=
irst if I bother you.

Thanks,
Zongyong Wu
