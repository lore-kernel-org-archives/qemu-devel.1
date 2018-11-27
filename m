Received: from eggs.gnu.org ([2001:4830:134:3::10]:33476)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gRaJX-0008KN-2a
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 05:09:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gRaJP-00064O-Pt
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 05:09:53 -0500
References: <20181125205000.10324-1-philmd@redhat.com>
	<20181125205000.10324-4-philmd@redhat.com>
	<602e637d-1e85-102a-4d90-b3c7aa4dac13@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <73fe6263-8dbf-c9b7-6e0e-cbcdc25118c3@redhat.com>
Date: Tue, 27 Nov 2018 11:09:36 +0100
MIME-Version: 1.0
In-Reply-To: <602e637d-1e85-102a-4d90-b3c7aa4dac13@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH for-3.1 03/25] MAINTAINERS: Add missing
 entries to the X86 section (AMD SEV)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>
Cc: qemu-trivial@nongnu.org, qemu-devel@nongnu.org

On 27/11/18 11:00, Thomas Huth wrote:
> On 2018-11-25 21:49, Philippe Mathieu-Daud=C3=A9 wrote:
>> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>> ---
>>  MAINTAINERS | 2 ++
>>  1 file changed, 2 insertions(+)
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index ae12323647..3b9996ab2c 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -300,8 +300,10 @@ F: target/i386/
>>  F: tests/tcg/i386/
>>  F: tests/tcg/x86_64/
>>  F: hw/i386/
>> +F: include/sysemu/sev.h
>>  F: disas/i386.c
>>  F: docs/qemu-cpu-models.texi
>> +F: docs/amd-memory-encryption.txt
>>  T: git https://github.com/ehabkost/qemu.git x86-next
>=20
> Not sure, but I think this should rather be added to the KVM section,
> not to the TCG section?

Yes, agreed.

Paolo
