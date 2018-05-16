Received: from eggs.gnu.org ([2001:4830:134:3::10]:36656)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1fImg6-00044Y-T9
	for qemu-devel@nongnu.org; Tue, 15 May 2018 23:00:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1fImg3-0003g2-QX
	for qemu-devel@nongnu.org; Tue, 15 May 2018 23:00:34 -0400
Received: from mail-pf0-x241.google.com ([2607:f8b0:400e:c00::241]:37624)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <aik@ozlabs.ru>) id 1fImg3-0003fT-D4
	for qemu-devel@nongnu.org; Tue, 15 May 2018 23:00:31 -0400
Received: by mail-pf0-x241.google.com with SMTP id e9-v6so1036489pfi.4
	for <qemu-devel@nongnu.org>; Tue, 15 May 2018 20:00:30 -0700 (PDT)
References: <20180313044944.21058-1-aik@ozlabs.ru>
	<20180313074442.xw5deum6xfw5tvjw@var.youpi.perso.aquilenet.fr>
	<87d13bdd-4a33-fb05-0c7c-36aabbd3d038@ozlabs.ru>
	<ad86c974-120e-4a2d-1db9-03d1b8ace247@redhat.com>
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <7ee1ea56-6081-e1f8-7da9-92776060e218@ozlabs.ru>
Date: Wed, 16 May 2018 13:00:24 +1000
MIME-Version: 1.0
In-Reply-To: <ad86c974-120e-4a2d-1db9-03d1b8ace247@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH qemu v2] slirp/debug: Print IP addresses in
 human readable form
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, Samuel Thibault <samuel.thibault@gnu.org>
Cc: qemu-devel@nongnu.org

On 16/5/18 12:30 am, Eric Blake wrote:
> On 05/14/2018 02:00 AM, Alexey Kardashevskiy wrote:
>> On 13/3/18 6:44 pm, Samuel Thibault wrote:
>>> Alexey Kardashevskiy, on mar. 13 mars 2018 15:49:44 +1100, wrote:
>>>> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
>>>
>>> Applied to my tree, thanks!
>>
>>
>> And what is your tree, is this something to be merged sometime later
>> somewhere? :)
> 
> Per MAINTAINERS:
> 
> SLIRP
> M: Samuel Thibault <samuel.thibault@ens-lyon.org>
> M: Jan Kiszka <jan.kiszka@siemens.com>
> S: Maintained
> F: slirp/
> F: net/slirp.c
> F: include/net/slirp.h
> T: git git://git.kiszka.org/qemu.git queues/slirp
> 
> which shows Jan's staging tree, but not Samuel's.
> 
> It's not a requirement for a maintainer to have a public-facing staging
> tree, but many of them do, as it gives you a chance to test that what will
> later be in a pull request matches what you expect.
> 
> At any rate,
> https://wiki.qemu.org/Contribute/SubmitAPatch#Is_my_patch_in.3F mentions
> that maintainers will batch together various related patches and send a
> pull request for inclusion in the main repository, thus even when a patch
> has been reviewed and staged, it may be another week or two before it lands
> in mainline.  Yes, it can feel slow, but in general it works out for the
> best (as we have more chances to flag potential problems before they affect
> everyone by being in mainline).


If it was 2 weeks or even 6 - I would not bother but when it is 2 months,
chances are it is forgotten/lost somewhere, hence my ping. I am not
complaining at all, just pinging :)



-- 
Alexey
