Received: from eggs.gnu.org ([2001:4830:134:3::10]:56556)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gXoFN-0003Uz-TO
	for qemu-devel@nongnu.org; Fri, 14 Dec 2018 09:15:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gXoFJ-0002Lh-Sk
	for qemu-devel@nongnu.org; Fri, 14 Dec 2018 09:15:21 -0500
Received: from mx1.redhat.com ([209.132.183.28]:36400)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1gXoFJ-0002EA-Es
	for qemu-devel@nongnu.org; Fri, 14 Dec 2018 09:15:17 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 2A0C930014DC
	for <qemu-devel@nongnu.org>; Fri, 14 Dec 2018 14:15:16 +0000 (UTC)
References: <20181207165250.17043-1-berrange@redhat.com>
	<a6e63d34-a8f3-90d6-5d0c-84df345ac09f@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <0ebd30f0-c90c-fda8-fa46-61bcc4d452ec@redhat.com>
Date: Fri, 14 Dec 2018 15:15:08 +0100
MIME-Version: 1.0
In-Reply-To: <a6e63d34-a8f3-90d6-5d0c-84df345ac09f@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [qemu-web PATCH] Add a .mailmap file for preferred
 name spellings
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, "=?UTF-8?Q?Daniel_P._Berrang=c3=a9?=" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>

On 2018-12-07 18:06, Eric Blake wrote:
> On 12/7/18 10:52 AM, Daniel P. Berrang=C3=A9 wrote:
>> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
>> ---
>> =C2=A0 .mailmap | 3 +++
>> =C2=A0 1 file changed, 3 insertions(+)
>> =C2=A0 create mode 100644 .mailmap
>>
>> diff --git a/.mailmap b/.mailmap
>> new file mode 100644
>> index 0000000..fa8ab68
>> --- /dev/null
>> +++ b/.mailmap
>> @@ -0,0 +1,3 @@
>> +# Preferred name forms where people have changed their
>> +# git author config, or having utf8/latin1 encoding issues.
>=20
> Tenses don't line up - but that's copied from qemu.git/.mailmap so we
> should fix it there too.=C2=A0 I suggest s/having/had/
>=20
> Reviewed-by: Eric Blake <eblake@redhat.com>

Thanks, applied (with the suggested fix).

 Thomas
