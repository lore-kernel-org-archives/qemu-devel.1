Received: from eggs.gnu.org ([2001:4830:134:3::10]:39885)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1gHAjz-0000Jd-QE
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 12:50:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1gHAjt-0001Lx-Uf
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 12:50:11 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43986)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1gHAjt-0001IQ-MJ
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 12:50:05 -0400
Date: Mon, 29 Oct 2018 16:49:58 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20181029164958.GF2417@work-vm>
References: <5a7360b9.bb243a.166be7858ac.Coremail.zly371549296@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5a7360b9.bb243a.166be7858ac.Coremail.zly371549296@163.com>
Subject: Re: [Qemu-devel] Qemu version issues migration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: zly371549296 <zly371549296@163.com>
Cc: qemu-devel <qemu-devel@nongnu.org>

* zly371549296 (zly371549296@163.com) wrote:
>          Hello, I would like to consult different versions of qemu virtual machine. If I am doing hot migration, my current environment is cloudstack+ KVM +ceph. One host has qemu version 2.9 and another has qemu version 2.6.I tried low version to high version can be migrated, but high version, how to migrate low version, please help guide, thank you!

Hi,
  Can you say what your command line is ?  What are you using as the
machine type, and what error do you get when you try the 2.9->26.1
migrate?

Dave

> 
> xiao  zeng
> 
> 2018-10-29
> 
> 
> zly371549296 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
