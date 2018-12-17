Received: from eggs.gnu.org ([2001:4830:134:3::10]:52915)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gYsrl-0001EK-FJ
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 08:23:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gYsri-0007Zl-9h
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 08:23:25 -0500
Received: from mx1.redhat.com ([209.132.183.28]:48084)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1gYsrh-0007Xf-Vb
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 08:23:22 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id BFBC1723D9
	for <qemu-devel@nongnu.org>; Mon, 17 Dec 2018 13:23:20 +0000 (UTC)
References: <20181207165414.17566-1-berrange@redhat.com>
	<294b4695-8eeb-da79-f40c-74b57f6ca629@redhat.com>
	<20181217121812.GF30264@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <a91f3da7-62d6-eece-5b80-c72766a7cbaf@redhat.com>
Date: Mon, 17 Dec 2018 14:23:18 +0100
MIME-Version: 1.0
In-Reply-To: <20181217121812.GF30264@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [qemu-web PATCH v2] Add license files for GPLv2+
 and CC-BY-SA-4.0
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "=?UTF-8?Q?Daniel_P._Berrang=c3=a9?=" <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>

On 2018-12-17 13:18, Daniel P. Berrang=C3=A9 wrote:
> On Mon, Dec 17, 2018 at 11:57:27AM +0100, Thomas Huth wrote:
>> On 2018-12-07 17:54, Daniel P. Berrang=C3=A9 wrote:
>>> The intent is that from this point onwards, content for this reposito=
ry
>>> is dual-licensed under the GPLv2+ and CC-BY-SA-4.0
[...]
>>> diff --git a/LICENSE.md b/LICENSE.md
>>> new file mode 100644
>>> index 0000000..ba73300
>>> --- /dev/null
>>> +++ b/LICENSE.md
>>> @@ -0,0 +1,18 @@
>>> +---
>>> +permalink: /license
>>> +title: QEMU website licensing
>>> +---
>>> +
>>> +Except where otherwise noted, the content in this repository is prov=
ided under
>>> +a choice of two licenses:
>>
>> I'd maybe replace "in this repository" with "on this website", since
>> it's not quite obvious for the normal user that the website is stored =
in
>> a git repository, too. (If you agree, I can fix this also up in case y=
ou
>> don't want to respin)
>=20
> Yes, it is fine if you change that when pushing.

All right, I've pushed it to the repository now.

 Thomas
