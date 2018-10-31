Received: from eggs.gnu.org ([2001:4830:134:3::10]:46343)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1gHmXd-00044l-0j
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 05:11:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1gHmXc-0006Lz-6i
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 05:11:56 -0400
Date: Wed, 31 Oct 2018 17:11:45 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20181031091145.GA26886@magic>
References: <20181031080415.23637-1-famz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181031080415.23637-1-famz@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] iotests: 082: Update output
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>

On Wed, 10/31 16:04, Fam Zheng wrote:
> Commit 9cbef9d68e (qemu-option: improve qemu_opts_print_help() output)
> affected qemu-img help output, and broke this test case.
> 
> Update the output reference to fix it.
> 
> Signed-off-by: Fam Zheng <famz@redhat.com>
> 
> ---
> 
> I'm once again looking at enabling iotests on patchew (via vm based
> tests), but immediately got blocked by this. :(

Please ignore this one, there's already another patch and comments buried deep
in my maildir. I'll peacefully wait for a fix then.

Fam
