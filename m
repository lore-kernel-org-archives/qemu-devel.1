Received: from eggs.gnu.org ([2001:4830:134:3::10]:59951)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1f9ZFQ-0007Tq-Ou
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 12:50:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1f9ZFL-0005jq-V5
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 12:50:56 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:49841)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1f9ZFL-0005jZ-NP
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 12:50:51 -0400
Date: Fri, 20 Apr 2018 12:50:50 -0400
From: "Emilio G. Cota" <cota@braap.org>
Message-ID: <20180420165050.GA24836@flamenco>
References: <1522980788-1252-1-git-send-email-cota@braap.org>
	<87in8lam44.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87in8lam44.fsf@linaro.org>
Subject: Re: [Qemu-devel] [PATCH v2 00/17] tcg: tb_lock_removal redux v2
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>

On Fri, Apr 20, 2018 at 17:17:15 +0100, Alex Bennée wrote:
> 
> Emilio G. Cota <cota@braap.org> writes:
> 
> > v1: http://lists.gnu.org/archive/html/qemu-devel/2018-02/msg06499.html
> >
> > Changes since v1:
> >
> <snip>
> 
> I was just catching up on reviews but there are a fair few conflicts in
> the later patches. I also note you have some comments from Richard to
> address. Should I wait until v3?

Yes, please.

Thanks,

		Emilio
