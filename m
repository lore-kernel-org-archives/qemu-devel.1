Received: from eggs.gnu.org ([2001:4830:134:3::10]:59708)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1dNgWd-0005Dl-6f
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 10:22:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1dNgWZ-0003af-7o
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 10:22:31 -0400
Received: from fanzine.igalia.com ([91.117.99.155]:44047)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <berto@igalia.com>) id 1dNgWY-0003Te-QU
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 10:22:27 -0400
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <20170621154309.0c4ff240@bahia.lab.toulouse-stg.fr.ibm.com>
References: <1497877896-35700-1-git-send-email-pradeep.jagadeesh@huawei.com>
	<1497877896-35700-2-git-send-email-pradeep.jagadeesh@huawei.com>
	<w51shitmrdw.fsf@maestria.local.igalia.com>
	<20170621154309.0c4ff240@bahia.lab.toulouse-stg.fr.ibm.com>
Date: Wed, 21 Jun 2017 16:21:36 +0200
Message-ID: <w51podxmnf3.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v5 1/5] throttle: factor out duplicate code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>
Cc: Pradeep Jagadeesh <pradeepkiruvale@gmail.com>, eric blake <eblake@redhat.com>, Pradeep Jagadeesh <pradeep.jagadeesh@huawei.com>, jani kokkonen <jani.kokkonen@huawei.com>, qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>

On Wed 21 Jun 2017 03:43:09 PM CEST, Greg Kurz wrote:
> On Wed, 21 Jun 2017 14:55:55 +0200
> Alberto Garcia <berto@igalia.com> wrote:
>
>> On Mon 19 Jun 2017 03:11:32 PM CEST, Pradeep Jagadeesh wrote:
>> > This patch factor out the duplicate throttle code that was present in
>> > block and fsdev devices.
>> >
>> > Signed-off-by: Pradeep Jagadeesh <pradeep.jagadeesh@huawei.com>  
>> 
>> Reviewed-by: Alberto Garcia <berto@igalia.com>
>
> Thanks ! Is it okay if this goes through my 9P tree ?

No problem from my side.

Berto
