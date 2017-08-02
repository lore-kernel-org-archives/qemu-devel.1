Received: from eggs.gnu.org ([2001:4830:134:3::10]:60945)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <adityaform@gmail.com>) id 1dcrIF-0002cw-34
	for qemu-devel@nongnu.org; Wed, 02 Aug 2017 06:54:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <adityaform@gmail.com>) id 1dcrIE-0000zl-6I
	for qemu-devel@nongnu.org; Wed, 02 Aug 2017 06:54:23 -0400
Received: from mail-wm0-x230.google.com ([2a00:1450:400c:c09::230]:38838)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <adityaform@gmail.com>)
	id 1dcrID-0000vh-UA
	for qemu-devel@nongnu.org; Wed, 02 Aug 2017 06:54:22 -0400
Received: by mail-wm0-x230.google.com with SMTP id m85so38086309wma.1
	for <qemu-devel@nongnu.org>; Wed, 02 Aug 2017 03:54:20 -0700 (PDT)
MIME-Version: 1.0
From: Aditya Bhardwaj <adityaform@gmail.com>
Date: Wed, 2 Aug 2017 16:24:18 +0530
Message-ID: <CAK6XCv5NYiSPq6Fy9NdtqhEz_zX6+irEngZcoweR6Gvc34Fq5w@mail.gmail.com>
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
*NITTTR (Ministry of MHRD, Govt. of India)*
*Sector-26, **Chandigarh - 160019  INDIA*
https://scholar.google.co.in/citations?user=rEHhEnEAAAAJ&hl=en
