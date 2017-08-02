Received: from eggs.gnu.org ([2001:4830:134:3::10]:33288)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <adityaform@gmail.com>) id 1dcrJ1-0002jT-EQ
	for qemu-devel@nongnu.org; Wed, 02 Aug 2017 06:55:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <adityaform@gmail.com>) id 1dcrJ0-0001ys-Ke
	for qemu-devel@nongnu.org; Wed, 02 Aug 2017 06:55:11 -0400
Received: from mail-wm0-x22f.google.com ([2a00:1450:400c:c09::22f]:36196)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <adityaform@gmail.com>)
	id 1dcrJ0-0001xp-Ed
	for qemu-devel@nongnu.org; Wed, 02 Aug 2017 06:55:10 -0400
Received: by mail-wm0-x22f.google.com with SMTP id t201so38018354wmt.1
	for <qemu-devel@nongnu.org>; Wed, 02 Aug 2017 03:55:10 -0700 (PDT)
MIME-Version: 1.0
From: Aditya Bhardwaj <adityaform@gmail.com>
Date: Wed, 2 Aug 2017 16:25:08 +0530
Message-ID: <CAK6XCv6oYSL=gQKhv6N5e7y620szz5Wc5g13OOMd=C54Lc=O7w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: [Qemu-devel] Where is the VM live migration code?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

My lab setup is: 3 HP Servers each of 4 GB RAM. Server 1 and Server 2:
installed with Virtualization using KVM on Redhat 6.5 System. On top of
this I am using libvirtd for managing virtual machines. NFS server is
installed on Server 3 for shared disk image. VM migration is working
correctly. Now i need to do some changes in "migration.c" but did not find
any source code of KVM-QEMU migration.

Where I can find the migration source code for KVM-QEMU. All are requested
to help me for this issue.






*Thank youWith Regards:Aditya Bhardwaj*
*Dept. of CSE *
