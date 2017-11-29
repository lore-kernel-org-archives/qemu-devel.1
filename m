Received: from eggs.gnu.org ([2001:4830:134:3::10]:56128)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eK5Ms-0006f7-8f
	for qemu-devel@nongnu.org; Wed, 29 Nov 2017 11:37:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eK5Mm-0002wW-Cr
	for qemu-devel@nongnu.org; Wed, 29 Nov 2017 11:37:50 -0500
Received: from mx1.redhat.com ([209.132.183.28]:51154)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1eK5Mm-0002uW-70
	for qemu-devel@nongnu.org; Wed, 29 Nov 2017 11:37:44 -0500
References: <20171129153116.26243-1-eblake@redhat.com>
	<CAFEAcA8RdvDxTkAZdEzdBbFfmXN4GJUU7pydDPk++sPYHJfk8w@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <1991cb7a-c65a-7918-275f-b10531139d88@redhat.com>
Date: Wed, 29 Nov 2017 17:37:38 +0100
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8RdvDxTkAZdEzdBbFfmXN4GJUU7pydDPk++sPYHJfk8w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [qemu-web PATCH] Mention website maintainence
 under Contribute
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, Eric Blake <eblake@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Fam Zheng <famz@redhat.com>

On 29/11/2017 17:22, Peter Maydell wrote:
> On 29 November 2017 at 15:31, Eric Blake <eblake@redhat.com> wrote:
>> Web (and other doc) updates are also valid contributions.
>>
>> Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
>> Signed-off-by: Eric Blake <eblake@redhat.com>
>> ---
>>  contribute.md | 4 +++-
>>  1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/contribute.md b/contribute.md
>> index bf4a55d..88baee6 100644
>> --- a/contribute.md
>> +++ b/contribute.md
>> @@ -12,4 +12,6 @@ permalink: /contribute/
>>  * Chat with the developers on IRC: irc.oftc.net, channel #qemu
>>
>>  * Read developer documentation: &ldquo;[Getting started for developer=
s](https://wiki.qemu.org/Documentation/GettingStartedDevelopers)&rdquo;,
>> -  &ldquo;[Contributor FAQ](https://wiki.qemu.org/Contribute/FAQ)&rdqu=
o;, &ldquo;[How to submit a patch](https://wiki.qemu.org/Contribute/Submi=
tAPatch)&rdquo;
>> +  &ldquo;[Contributor FAQ](https://wiki.qemu.org/Contribute/FAQ)&rdqu=
o;,
>> +  &ldquo;[How to submit a patch](https://wiki.qemu.org/Contribute/Sub=
mitAPatch)&rdquo;,
>> +  &ldquo;[Improve the website](https://www.qemu.org/2017/02/04/the-ne=
w-qemu-website-is-up/)&rdquo;
>=20
> Ah, I was vaguely thinking about this the other day; that we should
> improve https://wiki.qemu.org/Contribute so that it puts contributions
> to documentation, the website, etc on a clearer footing that's more
> on par with "contribute code" (possibly by hiving off the "writing
> code" bits to a separate section).
>=20
> We now seem to have two landing pages for "start contributing",
> though -- one on the main website and one on the wiki.

Apart from the infrastructure part, everything else in the wiki page
probably should be moved to the website.

Then, the wiki "Contribute" can be moved to "Contribute/Infrastructure"
(and the link in the side bar changed from "Start Here" to "Project
Infrastructure").

Thanks,

Paolo
