Received: from eggs.gnu.org ([2001:4830:134:3::10]:41182)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gNfhs-0005ZS-VQ
	for qemu-devel@nongnu.org; Fri, 16 Nov 2018 10:06:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gNfhp-0001lz-Qn
	for qemu-devel@nongnu.org; Fri, 16 Nov 2018 10:06:52 -0500
References: <20181115225052.1322639-1-eblake@redhat.com>
	<20181116102659.GA28597@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <bef6b1f7-327a-a786-a9c2-d69386eb98d8@redhat.com>
Date: Fri, 16 Nov 2018 09:06:32 -0600
MIME-Version: 1.0
In-Reply-To: <20181116102659.GA28597@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2] qapi: Reduce Makefile boilerplate
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-trivial@nongnu.org, pbonzini@redhat.com, armbru@redhat.com, xiezhide@huawei.com

On 11/16/18 4:26 AM, Daniel P. Berrang=C3=A9 wrote:

>>   Makefile      | 192 ++++++------------------------------------------=
--
>>   Makefile.objs |  75 ++------------------
>>   2 files changed, 30 insertions(+), 237 deletions(-)
>=20
> Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
>=20
> Though I'd also suggest .gitignore is updated to use wildcards
> to exclude the generated files.

Oh, good idea. v3 coming up

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
