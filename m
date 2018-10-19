Received: from eggs.gnu.org ([2001:4830:134:3::10]:46406)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1gDVJn-0005BG-OK
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 10:00:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1gDVJn-0002wl-4b
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 09:59:59 -0400
References: <20181018143042.29588-1-eric.auger@redhat.com>
	<20181018143042.29588-8-eric.auger@redhat.com>
	<9f8fa71c-555c-72d4-70a7-031f9b69e9bc@linaro.org>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <cfbbabcd-fd98-6451-7673-5e4bd19c1908@redhat.com>
Date: Fri, 19 Oct 2018 15:59:45 +0200
MIME-Version: 1.0
In-Reply-To: <9f8fa71c-555c-72d4-70a7-031f9b69e9bc@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC v4 07/16] hw/arm/virt: Implement kvm_type
 function for 3.2 machine
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>, eric.auger.pro@gmail.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org, peter.maydell@linaro.org, shameerali.kolothum.thodi@huawei.com, kwangwoo.lee@sk.com, imammedo@redhat.com, david@redhat.com
Cc: drjones@redhat.com, dgilbert@redhat.com, Suzuki.Poulose@arm.com

Hi Richard,

On 10/19/18 4:58 AM, Richard Henderson wrote:
> On 10/18/18 7:30 AM, Eric Auger wrote:
>> +#define SZ_1G (1024ULL * 1024 * 1024)
> 
> <qemu/units.h> already defines GiB.
noted

thanks!

Eric
> 
> 
> r~
> 
