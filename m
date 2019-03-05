Received: from eggs.gnu.org ([209.51.188.92]:60027)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1h1F88-0002Ze-0s
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 13:49:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1h1F86-0006cC-VR
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 13:49:31 -0500
Received: from mx1.redhat.com ([209.132.183.28]:45034)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1h1F86-0006TA-Lr
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 13:49:30 -0500
References: <20190305181602.9051-1-dgilbert@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <2fb69ec6-cbfb-e2b9-2631-2e10be236a9e@redhat.com>
Date: Tue, 5 Mar 2019 12:49:25 -0600
MIME-Version: 1.0
In-Reply-To: <20190305181602.9051-1-dgilbert@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PULL 00/21] migration queue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>, qemu-devel@nongnu.org, quintela@redhat.com, peterx@redhat.com, marcel.apfelbaum@gmail.com, wei.w.wang@intel.com, yury-kotov@yandex-team.ru, chen.zhang@intel.com, Peter Maydell <peter.maydell@linaro.org>

On 3/5/19 12:15 PM, Dr. David Alan Gilbert (git) wrote:
> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> 
> The following changes since commit 0984a157c1c053394adbf64ed7de97f1aebe6a2d:
> 
>    Merge remote-tracking branch 'remotes/jasowang/tags/net-pull-request' into staging (2019-03-05 09:33:20 +0000)
> 
> are available in the Git repository at:
> 
>    git://github.com/dagrh/qemu.git tags/pull-migration-20190305a
> 
> for you to fetch changes up to 3feabbb5fc5e3d5504c735a77ebd1d7fc1eabb9b:
> 
>    qapi/migration.json: Remove a variable that doesn't exist in example (2019-03-05 18:04:05 +0000)
> 

> Juan Quintela (3):
>        tests: Add migration xbzrle test
>        migration: Create socket-address parameter

I raised some comments on this one (10/21). I'll leave it up to others 
to decide if those warrant a v2 pull request or merely a followup patch.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org
