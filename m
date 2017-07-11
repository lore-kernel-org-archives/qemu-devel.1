Received: from eggs.gnu.org ([2001:4830:134:3::10]:54531)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dUq84-00041x-PU
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 04:02:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dUq81-0003Me-OA
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 04:02:44 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52644)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1dUq81-0003MQ-IS
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 04:02:41 -0400
References: <D5741445-7EFD-4AF1-8DB2-E4AFA93CBB1A@icloud.com>
	<d2f285a7-4bba-5ece-f327-fc4c5e61296e@redhat.com>
	<50811290-839A-4F06-9D90-4D6E45BB3DB4@icloud.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <10ff2dc0-d17e-126d-e11a-cc508ae8edfc@redhat.com>
Date: Tue, 11 Jul 2017 10:02:38 +0200
MIME-Version: 1.0
In-Reply-To: <50811290-839A-4F06-9D90-4D6E45BB3DB4@icloud.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] test-i386: Make x86 test program compile
 on clang
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Theodore Dubois <tblodt@icloud.com>
Cc: qemu-devel@nongnu.org

On 11/07/2017 00:13, Theodore Dubois wrote:
> I don=E2=80=99t believe so, I haven=E2=80=99t been able to find it in t=
he bug database.

This is now https://bugs.llvm.org/show_bug.cgi?id=3D33741.

Paolo

> ~Theodore
>=20
>> On Jul 10, 2017, at 2:48 PM, Paolo Bonzini <pbonzini@redhat.com> wrote=
:
>>
>> On 10/07/2017 22:57, Theodore Dubois wrote:
>>>  - Clang doesn't support size suffixes on the loop instructions.
>>
>> Has this bug been reported?
>>
>> Paolo
>>
>=20
