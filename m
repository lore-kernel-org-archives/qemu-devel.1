Received: from eggs.gnu.org ([2001:4830:134:3::10]:55133)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1ec8lD-00042r-9g
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 06:53:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1ec8lC-0000Ub-Dl
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 06:53:35 -0500
Received: from mx1.redhat.com ([209.132.183.28]:46006)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1ec8lC-0000UO-7h
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 06:53:34 -0500
References: <20180116231824.27114-1-shaun.reitan@ndchost.com>
	<5deda3ef-d5e4-c2a7-5556-4c46c26045ad@redhat.com>
	<em16de302b-9432-40ce-983f-88bb9dc5bba2@wkst222-laptop>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <b1b42a14-fe8f-858f-dd6f-70448bd805bf@redhat.com>
Date: Thu, 18 Jan 2018 19:53:29 +0800
MIME-Version: 1.0
In-Reply-To: <em16de302b-9432-40ce-983f-88bb9dc5bba2@wkst222-laptop>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] Add ability to provide ifname when using
 netdev bridge or tap helper
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Shaun Reitan <shaun.reitan@ndchost.com>, Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>



On 2018=E5=B9=B401=E6=9C=8818=E6=97=A5 02:11, Shaun Reitan wrote:
> Ok, how should i proceed with this?=C2=A0 I can attempt to write a=20
> whitelist/blacklist check if that is what's needed.
>
> --=20
> Shaun Reitan
> NDCHost.com=20

I think you can try.

Thanks
