Received: from eggs.gnu.org ([2001:4830:134:3::10]:55741)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eyftG-0001j1-5Z
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 11:43:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eyftF-0005on-Fa
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 11:43:02 -0400
References: <20180321153124.5357-1-berrange@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <880c56f0-0ae6-c579-5345-1f9637dcf07e@redhat.com>
Date: Wed, 21 Mar 2018 10:42:57 -0500
MIME-Version: 1.0
In-Reply-To: <20180321153124.5357-1-berrange@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] block: drop moderated sheepdog mailing
 list from MAINTAINERS file
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "=?UTF-8?Q?Daniel_P._Berrang=c3=a9?=" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Hitoshi Mitake <mitake.hitoshi@lab.ntt.co.jp>, Jeff Cody <jcody@redhat.com>, Liu Yuan <namei.unix@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>

On 03/21/2018 10:31 AM, Daniel P. Berrang=C3=A9 wrote:
> The sheepdog mailing list is setup to stop and queue messages from
> non-subscribers, pending moderator approval. Unfortunately it seems
> that the moderation queue is not actively dealt with. Even when message=
s
> are approved, the sender is never added to the whitelist, so every
> future mail the same sender continues to get stopped for moderation.
>=20
> MAINTAINERS entries should be responsive and not uneccessarily block
> mails from QEMU contributors, so drop the sheepdog mailing list.
>=20
> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> ---
>   MAINTAINERS | 1 -
>   1 file changed, 1 deletion(-)

Perhaps the sheepdog list would like to know what we are doing, along=20
with a heads up that their list policy is unfriendly.  But I can't be=20
the one to tell them - if I were to add the sheepdog list in cc, I'd get=20
moderated.

It's annoyed me enough times that I agree with the change.

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
