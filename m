Received: from eggs.gnu.org ([2001:4830:134:3::10]:41139)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <shaun.reitan@ndchost.com>) id 1ecIBM-0004en-BG
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 16:57:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <shaun.reitan@ndchost.com>) id 1ecIBI-0001BO-DE
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 16:57:12 -0500
Received: from jade.ndchost.com ([204.10.36.36]:60404)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <shaun.reitan@ndchost.com>)
	id 1ecIBI-0000ny-1J
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 16:57:08 -0500
From: "Shaun Reitan" <shaun.reitan@ndchost.com>
Date: Thu, 18 Jan 2018 21:56:20 +0000
Message-Id: <em7c5f8d17-3941-4484-b36f-96d7b62fe972@ndc-wkst-2>
In-Reply-To: <b1b42a14-fe8f-858f-dd6f-70448bd805bf@redhat.com>
References: <20180116231824.27114-1-shaun.reitan@ndchost.com>
	<5deda3ef-d5e4-c2a7-5556-4c46c26045ad@redhat.com>
	<em16de302b-9432-40ce-983f-88bb9dc5bba2@wkst222-laptop>
	<b1b42a14-fe8f-858f-dd6f-70448bd805bf@redhat.com>
Reply-To: "Shaun Reitan" <shaun.reitan@ndchost.com>
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; charset=utf-8
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
To: Jason Wang <jasowang@redhat.com>, Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>

Would that make everyone happy? I dont want to work on this feature if=20
it's going to be denied still :)

--
Shaun Reitan
NDCHost.com

------ Original Message ------
From: "Jason Wang" <jasowang@redhat.com>
To: "Shaun Reitan" <shaun.reitan@ndchost.com>; "Eric Blake"=20
<eblake@redhat.com>; qemu-devel@nongnu.org
Cc: "Markus Armbruster" <armbru@redhat.com>
Sent: 2018-01-18 03:53:29 AM
Subject: Re: [Qemu-devel] [PATCH] Add ability to provide ifname when=20
using netdev bridge or tap helper

>
>
>On 2018=E5=B9=B401=E6=9C=8818=E6=97=A5 02:11, Shaun Reitan wrote:
>>Ok, how should i proceed with this?  I can attempt to write a=20
>>whitelist/blacklist check if that is what's needed.
>>
>>-- Shaun Reitan
>>NDCHost.com
>
>I think you can try.
>
>Thanks
