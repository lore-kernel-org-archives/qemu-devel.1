Received: from eggs.gnu.org ([2001:4830:134:3::10]:53736)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1drgKs-0008JR-DO
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 04:14:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1drgKm-0001Y2-O6
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 04:14:22 -0400
Received: from mx1.redhat.com ([209.132.183.28]:32944)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1drgKm-0001Xc-I5
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 04:14:16 -0400
References: <20170901153928.17058-1-ehabkost@redhat.com>
	<20170901154701.GO7570@localhost.localdomain>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <16c0d5ee-f132-42d2-4b69-ee67e99c2954@redhat.com>
Date: Tue, 12 Sep 2017 10:14:05 +0200
MIME-Version: 1.0
In-Reply-To: <20170901154701.GO7570@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] MAINTAINERS: Update git URLs for my trees
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org
Cc: Richard Henderson <rth@twiddle.net>, Peter Maydell <peter.maydell@linaro.org>, Marcel Apfelbaum <marcel@redhat.com>, Igor Mammedov <imammedo@redhat.com>

On 01/09/2017 17:47, Eduardo Habkost wrote:
> On Fri, Sep 01, 2017 at 12:39:28PM -0300, Eduardo Habkost wrote:
>> List the branches where I queue patches for Machine Core, NUMA,
>> Memory Backends, and X86.  Update the NUMA section to list the
>> "numa-next" branch instead of "numa".
>>
>> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
>> ---
>>  MAINTAINERS | 5 ++++-
>>  1 file changed, 4 insertions(+), 1 deletion(-)
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index ccee28b12d..d72d8183bf 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -250,6 +250,7 @@ S: Maintained
>>  F: target/i386/
>>  F: hw/i386/
>>  F: disas/i386.c
>> +T: git git://github.com/ehabkost/qemu.git x86-next
> 
> Note: in the case of X86, Paolo and Richard have their own trees
> too.  We probably should list them to avoid misleading people to
> think mine is the only one.
> 
> Paolo, Richard: any git URLs you would like to list here?

I don't have a public branch.  Because I generally collect random
patches and send them out when I have time to test, the public branch
might not even compile at times. :)

Paolo
