Received: from eggs.gnu.org ([2001:4830:134:3::10]:52037)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1fBJZe-00016i-No
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 08:31:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1fBJZd-0005Y8-4K
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 08:31:02 -0400
References: <20180424214550.32549-1-lersek@redhat.com>
	<20180424214550.32549-2-lersek@redhat.com>
	<e5a4a333-c960-59ce-a850-105a7b609084@redhat.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <79fe4f0e-9f17-a686-60be-ad6827a422e7@redhat.com>
Date: Wed, 25 Apr 2018 14:30:58 +0200
MIME-Version: 1.0
In-Reply-To: <e5a4a333-c960-59ce-a850-105a7b609084@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 1/6] qapi: fill in CpuInfoFast.arch in
 query-cpus-fast
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Richard Henderson <rth@twiddle.net>, qemu-stable@nongnu.org

On 04/25/18 00:30, Eric Blake wrote:
> On 04/24/2018 04:45 PM, Laszlo Ersek wrote:
>> Commit ca230ff33f89 added added the @arch field to @CpuInfoFast, but it
> 
> s/added added/added/

The more I edit commit messages, the more I mess them up :)

Thanks!
Laszlo
