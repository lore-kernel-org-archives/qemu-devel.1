Received: from eggs.gnu.org ([2001:4830:134:3::10]:39250)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fRAIV-0003o2-Gs
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 01:50:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fRAIR-00027Q-Ie
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 01:50:51 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:43146 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1fRAIR-00027B-Du
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 01:50:47 -0400
References: <20180531194843.21172-1-samuel.thibault@ens-lyon.org>
	<20180606131407.c757uawwqjsp3hev@var.youpi.perso.aquilenet.fr>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <eeef5c11-a82f-fffc-a9fa-a47536ad7392@redhat.com>
Date: Fri, 8 Jun 2018 07:50:44 +0200
MIME-Version: 1.0
In-Reply-To: <20180606131407.c757uawwqjsp3hev@var.youpi.perso.aquilenet.fr>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] slirp: Add Samuel Thibault's staging tree
 for slirp
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Samuel Thibault <samuel.thibault@gnu.org>, qemu-devel@nongnu.org, peter.maydell@linaro.org
Cc: jan.kiszka@siemens.com

On 06.06.2018 15:14, Samuel Thibault wrote:
> Ping? I'm not sure who I am supposed to get a review from, or if I have
> to have one at all?
> 
> Samuel
> 
> Samuel Thibault, le jeu. 31 mai 2018 21:48:43 +0200, a ecrit:
>> Signed-off-by: Samuel Thibault <samuel.thibault@ens-lyon.org>
>> ---
>>  MAINTAINERS | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 41cd3736a9..8822ae9b70 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -1675,6 +1675,7 @@ S: Maintained
>>  F: slirp/
>>  F: net/slirp.c
>>  F: include/net/slirp.h
>> +T: git http://people.debian.org/~sthibault/qemu.git slirp
>>  T: git git://git.kiszka.org/qemu.git queues/slirp

FWIW:

Acked-by: Thomas Huth <thuth@redhat.com>
