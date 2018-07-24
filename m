Received: from eggs.gnu.org ([2001:4830:134:3::10]:33758)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fhzih-0000jz-3Q
	for qemu-devel@nongnu.org; Tue, 24 Jul 2018 11:59:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fhzif-0001mp-Ir
	for qemu-devel@nongnu.org; Tue, 24 Jul 2018 11:59:26 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:59714 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1fhzif-0001mT-Ee
	for qemu-devel@nongnu.org; Tue, 24 Jul 2018 11:59:25 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 035D07DAC2
	for <qemu-devel@nongnu.org>; Tue, 24 Jul 2018 15:59:25 +0000 (UTC)
References: <20180716073226.21127-1-armbru@redhat.com>
	<20180716073226.21127-3-armbru@redhat.com>
	<20180716093944.GL5616@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <1bcea184-c059-8bf9-81fc-257ae601824f@redhat.com>
Date: Tue, 24 Jul 2018 10:59:22 -0500
MIME-Version: 1.0
In-Reply-To: <20180716093944.GL5616@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [libvirt] [PATCH 2/2] MAINTAINERS: New section
 "Incompatible changes", copy libvir-list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "=?UTF-8?Q?Daniel_P._Berrang=c3=a9?=" <berrange@redhat.com>, Markus Armbruster <armbru@redhat.com>
Cc: libvir-list@redhat.com, thuth@redhat.com, cohuck@redhat.com, pkrempa@redhat.com, qemu-devel@nongnu.org

On 07/16/2018 04:39 AM, Daniel P. Berrang=C3=A9 wrote:

>=20
> Note, that libvir-list requires senders to be subscribed before mails a=
re
> delivered, otherwise they go into moderation queue. My normal approach.=
 as
> the person moderating, is to whitelist all human senders who get modera=
ted,
> so it is only a one-time pain point per person.

Actually, the list bot is even more stupid than that - a first-time=20
poster that subscribes first is STILL moderated (and sometimes you can=20
see evidence of that when someone posts 2 or 3 nearly identical messages=20
in a short time - first before subscribing, then again after, thinking=20
that subscribing will make a difference). Whitelisting happens=20
independently from subscription.

>=20
> Thankyou spammers :-(

But also a hearty thank you to all list moderators that reduce the=20
amount of spam actually making it to the list.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
