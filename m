Received: from eggs.gnu.org ([2001:4830:134:3::10]:52851)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1eR3ax-0000ch-6J
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 17:09:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1eR3at-0000Ij-7X
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 17:09:11 -0500
Received: from mx1.redhat.com ([209.132.183.28]:45688)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1eR3at-0000IO-1N
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 17:09:07 -0500
Date: Mon, 18 Dec 2017 20:09:01 -0200
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20171218220901.GE5209@localhost.localdomain>
References: <20171214040855.22231-1-douly.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171214040855.22231-1-douly.fnst@cn.fujitsu.com>
Subject: Re: [Qemu-devel] [RESEND PATCH for-2.12 0/2] ACPI/unit-test: Add a
 testcase
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Dou Liyang <douly.fnst@cn.fujitsu.com>
Cc: imammedo@redhat.com, mst@redhat.com, peter.maydell@linaro.org, qemu-devel@nongnu.org, indou.takao@jp.fujitsu.com

On Thu, Dec 14, 2017 at 12:08:53PM +0800, Dou Liyang wrote:
> These are the patches left over from the pull request:
> 
>   [Qemu-devel] [PULL 0/9] x86 and machine queue, 2017-10-05
> 
> because of some errors when tested by "make check" command[1].
> 
> Now, the QEMU 2.11.0 has been released, rebase/retest/respin them
> for v2.12 dev.
> 
> Changelog:
>   --Rebase and retest this patch in v2.11.0
>   --Update the DSDT.numamem:
> 
> [1]: http://lists.gnu.org/archive/html/qemu-devel/2017-10/msg01334.html

Do we know what caused the failures Peter saw, and if we can now
be sure it won't happen again?

-- 
Eduardo
