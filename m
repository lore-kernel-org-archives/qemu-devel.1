Received: from eggs.gnu.org ([2001:4830:134:3::10]:57712)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mmarek@suse.com>) id 1chHi6-0000VS-Ls
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 10:23:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mmarek@suse.com>) id 1chHi2-0004qf-KH
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 10:23:06 -0500
Received: from mx2.suse.de ([195.135.220.15]:51036)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mmarek@suse.com>) id 1chHi2-0004pG-6D
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 10:23:02 -0500
References: <148794791903.177.12506775196291811914@0e2666bad730>
From: Michal Marek <mmarek@suse.com>
Message-ID: <38f8bb7a-63e6-d718-2f2f-9530bc659040@suse.com>
Date: Fri, 24 Feb 2017 16:22:57 +0100
MIME-Version: 1.0
In-Reply-To: <148794791903.177.12506775196291811914@0e2666bad730>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] target-s390x: Implement stfl and stfle
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: famz@redhat.com, rth@twiddle.net, agraf@suse.de, ebischoff@suse.com, mbenes@suse.cz

On 2017-02-24 15:51, no-reply@patchew.org wrote:
> Hi,
> 
> This series seems to have some coding style problems. See output below for
> more information:
[...]
> === OUTPUT BEGIN ===
> Checking PATCH 1/1: target-s390x: Implement stfl and stfle...
> ERROR: braces {} are necessary for all arms of this statement
> #108: FILE: target/s390x/misc_helper.c:522:
> +    if (need <= len)
> [...]
> +    else
> [...]

I was not aware of this coding style requirement. I will wait if I get
more feedback from humans and resubmit.

Michal
