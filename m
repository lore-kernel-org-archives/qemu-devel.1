Received: from eggs.gnu.org ([2001:4830:134:3::10]:38594)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lbloch@janustech.com>) id 1fihc5-0003f3-Ky
	for qemu-devel@nongnu.org; Thu, 26 Jul 2018 10:51:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lbloch@janustech.com>) id 1fihc4-0004ci-Tz
	for qemu-devel@nongnu.org; Thu, 26 Jul 2018 10:51:33 -0400
References: <20180725142758.9980-1-lbloch@janustech.com>
	<20180725142758.9980-3-lbloch@janustech.com>
	<20180726100242.GD4215@localhost.localdomain>
	<5188afdb-8486-5fcf-27d4-c627a382291b@janustech.com>
	<20180726144657.GF4215@localhost.localdomain>
From: Leonid Bloch <lbloch@janustech.com>
Message-ID: <834dceb2-1e33-9057-767e-790572884974@janustech.com>
Date: Thu, 26 Jul 2018 17:51:10 +0300
MIME-Version: 1.0
In-Reply-To: <20180726144657.GF4215@localhost.localdomain>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB-large
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v5 2/4 for-3.0] qcow2: Options'
 documentation fixes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>, Eric Blake <eblake@redhat.com>

>> How about:
>>
>> "default: 4 times the cluster size; or if cache-size is specified, the part
>> of it which is not used for the L2 cache"
> 
> Even simpler, easier to understand and more accurate. I like it.

Thanks!

> 
> Kevin
> 
