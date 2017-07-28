Received: from eggs.gnu.org ([2001:4830:134:3::10]:39215)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1db3nU-0005mK-Bp
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 07:51:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1db3nQ-0004jl-SR
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 07:51:12 -0400
References: <20170728053610.15770-1-f4bug@amsat.org>
	<20170728053610.15770-47-f4bug@amsat.org>
	<20170728062426.GQ5117@lemon.lan>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <c3c6b7df-6629-982a-3135-a739979c36e7@redhat.com>
Date: Fri, 28 Jul 2017 13:50:47 +0200
MIME-Version: 1.0
In-Reply-To: <20170728062426.GQ5117@lemon.lan>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC PATCH 46/47] MAINTAINERS: add missing entries
 for Coccinelle scripts
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Cc: Eric Blake <eblake@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Markus Armbruster <armbru@redhat.com>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Laurent Vivier <lvivier@redhat.com>, qemu-trivial@nongnu.org, qemu-devel@nongnu.org

On 28/07/2017 08:24, Fam Zheng wrote:
> On Fri, 07/28 02:36, Philippe Mathieu-Daud=C3=A9 wrote:
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 224890643d..7854792765 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -1537,6 +1537,12 @@ Checkpatch
>>  S: Odd Fixes
>>  F: scripts/checkpatch.pl
>> =20
>> +Coccinelle scripts
>> +R: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
>> +S: Orphan
>=20
> "Orphan" sounds like we don't care much anymore but I suppose this is n=
ot the
> case. But I don't have any better idea either.

Just don't add it to the file.  It doesn't have a specific owner.

Paolo

>=20
> Fam
>=20
>> +F: scripts/cocci-macro-file.h
>> +F: scripts/coccinelle/
>> +
>>  Migration
>>  M: Juan Quintela <quintela@redhat.com>
>>  M: Dr. David Alan Gilbert <dgilbert@redhat.com>
>> @@ -1970,4 +1976,3 @@ Build system architecture
>>  M: Daniel P. Berrange <berrange@redhat.com>
>>  S: Odd Fixes
>>  F: docs/devel/build-system.txt
