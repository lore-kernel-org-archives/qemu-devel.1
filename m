Received: from eggs.gnu.org ([2001:4830:134:3::10]:38249)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <simon@ruderich.org>) id 1fAB9W-0006eT-0L
	for qemu-devel@nongnu.org; Sun, 22 Apr 2018 05:19:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <simon@ruderich.org>) id 1fAB9S-0002DY-3e
	for qemu-devel@nongnu.org; Sun, 22 Apr 2018 05:19:21 -0400
Received: from zucker2.schokokeks.org ([178.63.68.90]:33177)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <simon@ruderich.org>) id 1fAB9R-0002BO-Tg
	for qemu-devel@nongnu.org; Sun, 22 Apr 2018 05:19:18 -0400
Date: Sun, 22 Apr 2018 11:19:14 +0200
From: Simon Ruderich <simon@ruderich.org>
Message-ID: <20180422091914.GA29670@ruderich.org>
References: <20180412124834.GA2025@ruderich.org>
	<68c390f22ae2afc6539cd7b127063e3d9534d50b.1523537181.git.simon@ruderich.org>
	<24508722-fcc7-f795-061c-638c9aa1a0ce@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
In-Reply-To: <24508722-fcc7-f795-061c-638c9aa1a0ce@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 1/5] cpus: correct coding style in
 qmp_memsave/qmp_pmemsave
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org

On Tue, Apr 17, 2018 at 03:56:58PM -0500, Eric Blake wrote:
> On 04/12/2018 07:50 AM, Simon Ruderich wrote:
>> Signed-off-by: Simon Ruderich <simon@ruderich.org>
>> ---
>>  cpus.c | 6 ++++--
>>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> Reviewed-by: Eric Blake <eblake@redhat.com>
>
> However, as a meta-comment, this message was sent with:
>
>> Message-Id: <68c390f22ae2afc6539cd7b127063e3d9534d50b.1523537181.git.simon@ruderich.org>
>> In-Reply-To: <20180412124834.GA2025@ruderich.org>
>> References: <20180412124834.GA2025@ruderich.org>
>
> Looking on patchew, I see:
> http://patchew.org/QEMU/20180412124834.GA2025@ruderich.org/
> The requested URL /QEMU/20180412124834.GA2025@ruderich.org/ was not
> found on this server.
>
> For most messages, looking up the In-Reply-To: message-id gives the
> cover letter (for example,
> http://patchew.org/QEMU/20180412115838.10208-1-alex.bennee@linaro.org/)
>
> Similarly, looking on the list archives, I don't see the 0/5 cover
> letter, but rather that your messages are treated as threaded to your v1
> thread:
>
> https://lists.gnu.org/archive/html/qemu-devel/2018-04/threads.html#01388
>
> For the sake of tooling, it's best to send a v2 series with a new cover
> letter as a new top-level thread.

Yeah, I screwed that part up. Sorry for the extra work. Will fix
when I resend the series.

Regards
Simon
-- 
+ privacy is necessary
+ using gnupg http://gnupg.org
+ public key id: 0x92FEFDB7E44C32F9
