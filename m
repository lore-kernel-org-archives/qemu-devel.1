Received: from eggs.gnu.org ([2001:4830:134:3::10]:35070)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=555d4dacb=ross.lagerwall@citrix.com>)
	id 1eeIqO-00014G-Qe
	for qemu-devel@nongnu.org; Wed, 24 Jan 2018 06:03:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=555d4dacb=ross.lagerwall@citrix.com>)
	id 1eeIqJ-0007b5-Uh
	for qemu-devel@nongnu.org; Wed, 24 Jan 2018 06:03:52 -0500
Received: from smtp.citrix.com ([66.165.176.89]:45443)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <prvs=555d4dacb=ross.lagerwall@citrix.com>)
	id 1eeIqJ-0007WR-O3
	for qemu-devel@nongnu.org; Wed, 24 Jan 2018 06:03:47 -0500
References: <1508431916-9412-1-git-send-email-ian.jackson@eu.citrix.com>
	<20171020133001.GD11934@perard.uk.xensource.com>
	<23017.64539.31230.43449@mariner.uk.xensource.com>
From: Ross Lagerwall <ross.lagerwall@citrix.com>
Message-ID: <d2261f2c-b727-6b1c-183b-78a7661a8741@citrix.com>
Date: Wed, 24 Jan 2018 11:03:40 +0000
MIME-Version: 1.0
In-Reply-To: <23017.64539.31230.43449@mariner.uk.xensource.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v5 0/8] xen: xen-domid-restrict improvements
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Ian Jackson <ian.jackson@eu.citrix.com>, Anthony PERARD <anthony.perard@citrix.com>
Cc: qemu-devel@nongnu.org, Juergen Gross <jgross@suse.com>, Stefano Stabellini <sstabellini@kernel.org>, xen-devel@lists.xenproject.org

On 10/20/2017 02:37 PM, Ian Jackson wrote:
> Anthony PERARD writes ("Re: [PATCH v5 0/8] xen: xen-domid-restrict improvements"):
>> The patches in this v5 appear to be the same the one from the patch
>> series v4.
> 
> Erk, so they are.
> 
> I'll post a v5.1 in reply to this email.
> 

What's the status of this patch series? There don't seem to be many 
outstanding complaints but they haven't been pushed into master. At 
least the Xen changes have all been reviewed by Anthony (except for 
configure changes) so they could probably go in.

Thanks,
-- 
Ross Lagerwall
