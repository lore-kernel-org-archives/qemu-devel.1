Received: from eggs.gnu.org ([2001:4830:134:3::10]:33208)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1f0qRO-0007tz-OT
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 11:23:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1f0qRM-00050t-1z
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 11:23:14 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:33498 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1f0qRL-00050n-Uf
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 11:23:12 -0400
References: <20180327143014.1767669-1-eblake@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <9e3507d0-46aa-4b92-80aa-468dd45d399e@redhat.com>
Date: Tue, 27 Mar 2018 10:23:03 -0500
MIME-Version: 1.0
In-Reply-To: <20180327143014.1767669-1-eblake@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PULL 00/14] QAPI changes for 2018-03-27, 2.12-rc1
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>

On 03/27/2018 09:30 AM, Eric Blake wrote:
> The following changes since commit f58d9620aa4a514b1227074ff56eefd1334a6225:
> 
>    Merge remote-tracking branch 'remotes/rth/tags/pull-dt-20180326' into staging (2018-03-27 10:27:34 +0100)
> 
> are available in the Git repository at:
> 
>    git://repo.or.cz/qemu/ericb.git tags/pull-qapi-2018-03-27
> 
> for you to fetch changes up to 701a2432fea0a9a1741abf7a887fae26f5410970:
> 
>    hmp.c: Revert hmp_info_cpus output format change (2018-03-27 09:21:52 -0500)

v2 pull request sent to fix some last minute Reviewed-by tag corrections

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
