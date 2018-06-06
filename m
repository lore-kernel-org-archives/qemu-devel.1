Received: from eggs.gnu.org ([2001:4830:134:3::10]:59231)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fQbDA-0004is-IB
	for qemu-devel@nongnu.org; Wed, 06 Jun 2018 12:23:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fQbD7-0006M9-CU
	for qemu-devel@nongnu.org; Wed, 06 Jun 2018 12:23:00 -0400
Received: from mail-qk0-x241.google.com ([2607:f8b0:400d:c09::241]:44477)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fQbD7-0006LO-87
	for qemu-devel@nongnu.org; Wed, 06 Jun 2018 12:22:57 -0400
Received: by mail-qk0-x241.google.com with SMTP id 185-v6so4311981qkk.11
	for <qemu-devel@nongnu.org>; Wed, 06 Jun 2018 09:22:57 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180531194843.21172-1-samuel.thibault@ens-lyon.org>
	<20180606131407.c757uawwqjsp3hev@var.youpi.perso.aquilenet.fr>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <70ae3e2e-e14a-ab3d-bf6a-24637fd063cb@amsat.org>
Date: Wed, 6 Jun 2018 13:22:51 -0300
MIME-Version: 1.0
In-Reply-To: <20180606131407.c757uawwqjsp3hev@var.youpi.perso.aquilenet.fr>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
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

Hi Samuel,

On 06/06/2018 10:14 AM, Samuel Thibault wrote:
> Ping? I'm not sure who I am supposed to get a review from, or if I have
> to have one at all?

I think you don't need since your are the maintainer ;)

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

I tested it but got:

warning: redirecting to https://people.debian.org/~sthibault/qemu.git/

Can you use the https scheme?

Tested-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

>>  T: git git://git.kiszka.org/qemu.git queues/slirp
>>  
>>  Stubs
>> -- 
>> 2.17.0
>>
> 
